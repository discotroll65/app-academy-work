class Cat < ActiveRecord::Base
  validates :birth_date, :name, :description, presence: true
  validates :sex, inclusion: { in: ["m", "f"] }, presence: true
  validates(
    :color,
    inclusion: { in: ["white", "orange", "black", "calico"] },
    presence: true
  )

  def age
    Time.now.year - birth_date.year
  end

end