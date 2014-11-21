class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :advertiser
  belongs_to :advertisement
end
