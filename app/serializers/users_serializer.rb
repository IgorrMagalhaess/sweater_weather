class UsersSerializer
  include JSONAPI::Serializer
  attributes :email, :api_key

  set_id { "null"}
end
