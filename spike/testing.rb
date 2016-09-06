#! /usr/bin/env ruby

require 'set'
require 'pry'

class Station
  attr_accessor :name, :conn
  def initialize(*args)
    @name = args[0]
    @conn = {}
  end
  def to_s
    "#{@name} + #{@conn}"
  end
  def eql?(other)
    @name == other
  end
end

class Connection
  attr_accessor :station, :distance
  def initialize(*args)
    @station = args[0]
    @distance = args[1]
  end

  def to_s
    "#{@station} -> #{@distance}"
  end
end

class Conn
  attr_accessor :dest, :dist
  def initialize(dest,dist)
    @dest = dest
    @dist = dist
  end
end

# AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7

a = Station.new(:a)
b = Station.new(:b)
c = Station.new(:c)
d = Station.new(:d)
e = Station.new(:e)

a.conn[:b] = Conn.new(b,5)
b.conn[:c] = Conn.new(c,4)
c.conn[:d] = Conn.new(d,8)
d.conn[:c] = Conn.new(c,8)
d.conn[:e] = Conn.new(e,6)
a.conn[:d] = Conn.new(d,5)
c.conn[:e] = Conn.new(e,2)
e.conn[:b] = Conn.new(b,3)
a.conn[:e] = Conn.new(e,7)

# @n = Set.new [a,b,c,d,e]
@n = { :a => a, :b => b, :c => c, :d => d, :e => e }

def route_distance(*args)
  puts "Trip #{args}"
  j = 0
  o = @n[args.shift.to_sym]
  args.each do |s|
    j = j + o.conn[s.to_sym].dist
    o = @n[s.to_sym]
  end
 puts "distance #{j}"
end

def number_of_trips(start,finish, stops)
  puts "Trip #{start} to #{finish} with stops <= #{stops}"

  # traverse tree`
  # check if we have hit the stop limit
  # check if we have reached the destination
  # record the path
  # go back to previous station do again until
  # we reached destination or reached max limit

  start = @n[start.to_sym]
  finish = @n[finish.to_sym]

  puts "Start = #{start.name}"
  r = []
  get_routes r, start, finish, stops, 0

  puts "!!!!Dest #{r}"

end

@total_paths = 0

def get_routes(path,current,dest,max,travelled)

  current.conn.each do |_,v|
    travelled = travelled + 1

    if (dest == v.dest) && (travelled <= max)
        @total_paths = @total_paths + 1
    elsif travelled < max
      get_routes(path,v.dest,dest,max,travelled)
    end
    travelled = travelled - 1
  end

end

@total_exect_paths = 0
def numb_exact_trips(start,finish,stops)
  start = @n[start.to_sym]
  finish = @n[finish.to_sym]

  puts "Exact Routes = #{start.name} Hops = #{stops}"
  r = []
  get_exact_routes start, finish, stops, 0

end

def get_exact_routes(current,dest,max,travelled)
  current.conn.each do |_,v|
    travelled = travelled + 1

    if (dest == v.dest) && (travelled == max)
        @total_exect_paths = @total_exect_paths + 1
    elsif travelled < max
      get_exact_routes(v.dest,dest,max,travelled)
    end
    travelled = travelled - 1
  end

end

def shortest_path(origin,dest)
  start = @n[origin.to_sym]
  finish = @n[dest.to_sym]
  s_p = []
  unvisited = Set.new
  visited = Set.new{start}
  w_graph = { start.name => 0 }

  # All all nodes with infinity trip length
  # Need to mark the start as infinity as we need to get there.
  @n.each do | _, v |
    w_graph[v.name] = 999999
    unvisited << v
  end

  # If start and finish are not the same destination then mark it as 0 weght
  if start != finish
    w_graph[start.name] = 0
  end

  next_station = start

  while !reached_destination?(s_p,finish) do
    do_algorithm(next_station,w_graph,finish)
    next_station = figure_out_next_node_to_visit(next_station,w_graph)
    s_p << next_station
  end

  puts "wg #{w_graph}"
  puts "next station = #{next_station.name}"

  w_graph[finish.name]
end

def do_algorithm(current,weighted_graph,finish)
  # for each connection
  # add the weight of the current node + the dist to the connection (x)
  # if it is lower than the weight of that connection then make it the new
  # connection value.
  current_node_weight = weighted_graph[current.name]

  # On trips where start == finish we need to makr the first trip node weight as 0
  # to ensure the first iteration calcs the weights correctly then this should not happen
  # afterwards.
  if (current.name == finish.name)
    current_node_weight = 0
  end
  current.conn.each do |_,c|
    new_conn_weight = current_node_weight + c.dist
    weighted_graph[c.dest.name] = new_conn_weight unless new_conn_weight >= weighted_graph[c.dest.name]
  end

end

def figure_out_next_node_to_visit(current,weighted_graph)
  # for the current node were at
  # iterate through all the connections
  # figure out which ones are unvisited.
  # then return the connection with the next lowest weight.
  next_shortest_dist = 999999
  next_station = nil
  current.conn.each do |_,v|
    puts "connections #{v.dest.name} #{v.dist}"
    if (weighted_graph[v.dest.name] < next_shortest_dist)
      next_station = v.dest
      next_shortest_dist = v.dist
    end
  end
  next_station
end

def reached_destination?(path,dest)
  puts "PATH Size #{path.size}"
  (path.last == dest)
end

# there is a path between the origin and destination?
def there_is_a_path?
  true # assume there is for now
end

@how_many_paths = 0
def number_of_paths(from,to,max_dist)
  # Go through each connection
  # see if we are over the max dist
  # see if we are at our destination
  # recruse, go through each of the destinations
  @how_many_paths = 0
  st = @n[from.to_sym]
  fi = @n[to.to_sym]
  result = 0
  how_many_paths(st,fi,max_dist,0)
  @how_many_paths

end

def how_many_paths(station,f,max_dist,current_dist)
  puts "NEW station = #{station.name}"
  old_current = current_dist
  station.conn.each do |_,c|

    if (current_dist + c.dist) < max_dist
      puts "CURRENT DIST #{current_dist} #{station.name} to #{c.dest.name}  "
      puts "Dest=#{c.dest.name} and finish=#{f.name}"
      if c.dest == f
        @how_many_paths = @how_many_paths + 1
        puts "PING\n\n"
      end
      puts "recurse!"
      how_many_paths(c.dest,f,max_dist,(current_dist + c.dist))
    end
    puts "looped st=#{station.name} dest=#{c.dest.name} curr_dist=#{current_dist}, new=#{current_dist + c.dist}"
  end
  puts "outiie"
end

route_distance 'a', 'e', 'b', 'c', 'd'

number_of_trips 'c', 'c', 3
puts "# of trips #{@total_paths}"

numb_exact_trips 'a', 'c', 4
puts "!!!!Dest exact Routes =  #{@total_exect_paths}"

s = shortest_path 'b', 'b'
puts "Shortest Path a -> c = #{s}\n"
puts "\n\n"
x = number_of_paths 'c','c',30
puts"c to c Paths = #{x}"
