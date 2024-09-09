class Api::V1::CurrentUserSerializer < Transmutation::Serializer
  attributes :id, :name, :email
end
