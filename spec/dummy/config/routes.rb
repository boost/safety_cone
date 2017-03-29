Rails.application.routes.draw do
  mount SafetyConeMountable::Engine => "/cones"
end
