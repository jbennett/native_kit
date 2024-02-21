module NativeKit
  module ApplicationHelper
    def native_kit_site_manifest_tag
      tag.link rel: "manifest", href: "/manifest.json"
    end

    def native_kit_vapid_key(web_push_public_key: Rails.application.credentials.dig(:web_push, :public_key))
      tag.meta name: "web_push_public_key", content: Base64.urlsafe_decode64(web_push_public_key).bytes.to_json
    end
  end
end
