require"geoip"
geo = GeoIP.new("GeoLiteCity.dat")
#c= geo.city("unine.ch")
#puts("#{c.latitude} #{c.longitude}")

File.open("it-2004.sites", "rb").each_line do |line|
  #puts line
  begin
    domain= line[7..(line.index('.it/')+2)] 
    c= geo.city(domain)
    puts(c)
    #puts("#{line.strip} #{c.latitude} #{c.longitude}")
  rescue Exception=>e
    puts("Error while resolving #{line.strip}")
  end 
end
  
