json.success "1"
json.result @services do |service|
  json.id service.id
  json.title service.name
  json.url "#{service.id}"
  json.class "#{service.category}"
  json.start service.date.to_i*1000
  json.end service.date.to_i*1000
end
