def job(name, &block)
  jobs[name] = block
end

def jobs
  @jobs ||= {}
end

def print_jobs
  jobs.each do |job|
    puts job.inspect
  end
end

def run_jobs 
  jobs.each_pair do |name, proc|
    puts "About to run job: #{name}"
    proc.call  
  end
end

load("batch.rb")
print_jobs
run_jobs

