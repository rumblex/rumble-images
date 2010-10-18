

Dir["small/*"].each {|f| `git mv #{f} #{f.gsub(/http%3A%2F%2F/, '')}` }
Dir["full/*"].each {|f| `git mv #{f} #{f.gsub(/http%3A%2F%2F/, '')}` }
Dir["one_hour_left/small/*"].each {|f| `git mv #{f} #{f.gsub(/http%3A%2F%2F/, '')}` }
Dir["one_hour_left/full/*"].each {|f| `git mv #{f} #{f.gsub(/http%3A%2F%2F/, '')}` }