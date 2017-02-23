Rails.application.routes.draw do
  mount SafetyConeMountable::Engine => "/safety_cone_mountable"
end
