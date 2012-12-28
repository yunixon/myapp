class Gate < ActiveRecord::Base
  belongs_to :race
  belongs_to :horse
  has_many :bets
  attr_accessible :finish, :horse_id, :number, :race_id, :status

  def scratch

      self.bets.where(:status => 'Pending').each do |bet|
        Credit.create(:user_id => bet.user_id,
                           :meet_id => bet.meet_id,
                           :amount => bet.amount,
                           :description => "#{self.horse.name}--Scratched. Returned bet.",
                           :card_id => self.race.card_id,
                           :credit_type => "Scratched",
                           :track_id => self.track_id
                             ) 
       bet.status = 'Scratched'
       bet.amount = 0

       bet.save
       bet.user.update_ranking(self.race.card.meet.id, bet.amount)
     end
     self.status = 'Scratched'
     self.save
  end

  def total_bets(bet_type = nil)
    if bet_type
      self.bets.where(:bet_type => bet_type, :status => 'Pending').sum(:amount) 
    else
      self.bets.sum(:amount) 
    end 
  end


 # def odds
 #   return 0 if self.total_bets == 0
 #   floated_odds = self.race.total_bets.to_f / self.total_bets.to_f
 #   odds = (floated_odds * 20).round.to_f/20
 # end

  def odds(bet_type)
    return 0 if self.total_bets(bet_type) == 0
    floated_odds = self.race.total_bets(bet_type).to_f / self.total_bets(bet_type).to_f
    odds = (floated_odds * 20).round.to_f/20
  end



end
