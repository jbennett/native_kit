module NativeKit
  module ApplicationHelper
    def native_kit_site_manifest_tag
      tag.link rel: "manifest", href: "/manifest.json"
    end
  end
end
