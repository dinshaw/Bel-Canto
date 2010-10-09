class User < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions

  state_machine do
    # Note: The order of these states can not be changed.  If a new state is to be
    # added, add it to the bottom or the access_mask will break.
    state :trial # first one is initial state
    state :student
    state :advanced
    state :finished
    state :on_maintenance
    state :suspended

    event :promote do
      transitions :to => :student, :from => :trial
      transitions :to => :advanced, :from => :student
      transitions :to => :finished, :from => :advanced
    end

    event :demote do
      transitions :from => :student, :to => :trial
      transitions :from => :advanced, :to => :student
      transitions :from => :finished, :to => :advanced
    end

    event :maintenance do
      transitions :from => [:trial, :student, :advanced, :finished], :to => :on_maintenance
    end

    event :suspend do
      transitions :from => [:trial, :student, :advanced, :finished], :to => :suspended
    end

    event :reinstate do
      transitions :from => [:suspended, :on_maintenance], :to => :student
    end

  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable and :timeoutable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :admin, :editor, :state, :phone_numbers_attributes

  attr_accessor :state_transition

  has_many :phone_numbers
  has_many :private_lessons
  has_and_belongs_to_many :files, :class_name => 'Upload'
  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['number'].blank? }

  # validates :first_name, :presence => true
  # validates :last_name, :presence => true

  def full_name
    [first_name, last_name].join(' ')
  end

  def promotable?
    ['trial', 'student', 'advanced'].include?(state)
  end

  def demotable?
    ['student', 'advanced', 'finished'].include?(state)
  end

  def reinstatable?
    ['suspended', 'on_maintenance'].include?(state)    
  end
  
  def display_state
    state.titleize
  end
  
  def self.states
    state_machine.states.map(&:name).map(&:to_s)
  end
  
  def accessible_files
    @accessible_files ||= files
  end
end
