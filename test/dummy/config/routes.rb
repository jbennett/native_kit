Rails.application.routes.draw do
  mount NativeKit::Engine => "/native_kit"
end
