class User < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions

  state_machine do
    state :trial # first one is initial state
    state :student
    state :advanced
    state :finished
    state :on_maintenance
    state :excommunicated    
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
      transitions :from => :all, :to => :on_maintenance
    end
  
    event :suspend do
      transitions :from => :all, :to => :suspended
    end  
    
    event :excommunicate do
      transitions :from => :all, :to => :excommunicated
    end
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable and :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :admin, :editor, :state
  
  has_many :phone_numbers
  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true
    
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  def full_name
    [first_name, last_name].join(' ')
  end

end
