json.array!(@services) do |service|
  json.extract! service, :id, :name, :description
    json.title service.name
    json.start service.date
    # json.end service.date
    json.url service_url(service)
end
