module ActionDispatch::Routing
  class Mapper
    def mount_native_kit(skip_webmanifest: false)
      get "manifest" => "native_kit/pwa#manifest" unless skip_webmanifest
    end
  end
end
