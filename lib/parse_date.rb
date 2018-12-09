module ParseDate
  def position_search(search_time, pos)
    temp = search_time.to_s.split('-')[pos].strip.split("/")
    temp[2] + "-" + temp[1] + "-" + temp[0]
  end
end