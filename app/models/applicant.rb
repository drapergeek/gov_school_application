class Applicant < ActiveRecord::Base
  attr_accessible :address, :email, :english_teacher, :first_name, :gender, :grade, :home_phone, :last_name, 
    :math_teacher, :middle_name, :parent_first_name, :parent_last_name, :school_id, :science_teacher, :work_phone,
    :school_phone, :counselor_name, :due_to, :date_due, :english_teacher_email, :science_teacher_email, :math_teacher_email, 
    :applicant_confirmation, :parent_confirmation
    belongs_to :school
    has_many :teacher_recommendations
  
  before_save :strip_extra_characters
  
  validates :school, presence:true
  validates :first_name, presence:true, length: {maximum: 25}
  validates :last_name, presence:true, length: {maximum: 25}
  validates :grade, presence:true
  validates :parent_first_name, presence:true, length: {maximum: 25}
  validates :parent_last_name, presence:true, length: {maximum: 25}
  validates :address, presence:true
  VALID_PHONE_REGEX = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/
  validates :home_phone, presence:true, format: {with:VALID_PHONE_REGEX}
  validates :work_phone, presence: true, format: {with:VALID_PHONE_REGEX}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
  validates :math_teacher, presence:true, length: {maximum: 50}
  validates :science_teacher, presence:true, length: {maximum: 50}
  validates :english_teacher, presence:true, length: {maximum: 50}
  validates :applicant_confirmation, presence:true
  validates :parent_confirmation, presence:true
  validates :school_phone, presence:true, format: {with:VALID_PHONE_REGEX}, on: :update
  validates :counselor_name, presence:true, on: :update
  validates :due_to, presence:true, on: :update
  validates :date_due, presence:true, on: :update
  
  

  def strip_extra_characters
    self.home_phone = remove_non_digit_characters(home_phone)
    self.work_phone = remove_non_digit_characters(work_phone)
    self.school_phone = remove_non_digit_characters(school_phone)
  end
  
  def to_s
    "#{first_name} #{last_name}"
  end
    
  def science_recommendation
    science_recommendation = find_recommendation_by_subject("Science")
  end
  def math_recommendation
    math_recommendation = find_recommendation_by_subject("Math")
  end
  def english_recommendation
    english_recommendation = find_recommendation_by_subject("English")
  end
 
  
  private 
  
  def find_recommendation_by_subject(subject)
    teacher_recommendation = teacher_recommendations.find_by_subject(subject)
  end

  def remove_non_digit_characters(string)
    if string.present?
      string.gsub(/[^0-9]/, "")
    end
  end
end
