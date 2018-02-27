# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program
require 'date'


def find(id)
  candidate = nil
  @candidates.each_index do
    |x|
    if @candidates[x][:id] == id
      candidate = @candidates[x]
    end
  end

  return candidate
end


def experienced?(candidate)
  if candidate[:years_of_experience] > 1
    return true
  else
    return false
  end
end


def qualified_candidates(candidates)
  qualified = []
  candidates.each do
    |x|
    if applied_in_past_15_days?(x) && is_adult?(x) && gh_points?(x) && know_rb_phy?(x) && experienced?(x)
      qualified.push(x)
    end
  end
  return qualified
end


def ordered_by_qualifications(candidates)
  sorted = candidates.sort_by { |x| [ -x[:years_of_experience], -x[:github_points] ] }

  pp sorted
end



#----------------------- More methods will go below --------------------------
private

def gh_points?(candidate)
  if candidate[:github_points] >= 100
    return true
  else
    return false
  end
end

def is_adult?(candidate)
  if candidate[:age] >= 18
    return true
  else
    return false
  end
end

def applied_in_past_15_days?(candidate)
  today = Date.parse(Time.now.getlocal('-08:00').to_s)
  date_applied = Date.parse(candidate[:date_applied].to_s)
  if (today - date_applied).round <= 15
    return true
  else
    return  false
  end
end

def know_rb_phy?(candidate)
  candidate[:languages].each do
    |x|
    if x == 'Ruby' || x == 'Python'
      return true
    end
  end
  return false
end