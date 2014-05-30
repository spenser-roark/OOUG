module RegionHelper

def current_region(id)
  Region.find(id)
end

end
