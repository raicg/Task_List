class DatetimeValidator < ActiveModel::Validator
    def validate(record)
        if record.due_date == nil
            record.errors[:base] << "Time and Date must be defined."
        elsif record.due_date < Time.current()
            record.errors[:base] << "Time and Date must be later then now."
        end
    end
end


class Task < ApplicationRecord
    belongs_to :user

    validates :title, length: {
        minimum: 5 }


    validates_with DatetimeValidator

end
