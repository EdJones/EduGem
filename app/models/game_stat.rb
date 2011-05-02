class GameStat < ActiveRecord::Base
      
  def update_high_score(points)
     if points > self.high_score
        self.update_attribute(:high_score, (points))
      end
  end
     
  def update_last_level(level)
      if level> self.last_level
        self.update_attribute(:last_level, level)
      end
     end
     
   def update_start_time()
       self.update_attribute(:start_time, Time.now)
   end    
     
   def time_since_start
       time_since_start = Time.now - self.start_time
   end
   
   def update_game_duration()
        self.update_attribute(:game_duration, time_since_start)
    end 
end
