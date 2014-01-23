module SheetsMultiSite
  module StylesheetTags
    include Radiant::Taggable
    class TagError < StandardError; end
    desc %{
      Does the same thing as <r:stylesheet /> tag but takes base_url param (required) to append to path for multisite support.
    }
    tag 'multi_site_stylesheet' do |tag|
    slug = (tag.attr['slug'] || tag.attr['name'])
    site_id = (tag.attr['site_id'] || Site.default.id)
    raise TagError.new("`stylesheet' tag must contain a `slug' attribute.") unless slug
    if (stylesheet = StylesheetPage.find_by_slug(slug))
      mime_type = tag.attr['type'] || stylesheet.headers['Content-Type']
      path = Site.find_by_id(site_id).url + stylesheet.path
      rel = tag.attr.delete('rel') || 'stylesheet'
      optional_attributes = tag.attr.except('slug', 'name', 'as', 'type', 'site_id').inject('') { |s, (k, v)| s << %{#{k}="#{v}" } }.strip
      optional_attributes = " #{optional_attributes}" unless optional_attributes.empty?
      case tag.attr['as']
      when 'url','path'
        path
      when 'inline'
        %{<style type="#{mime_type}"#{optional_attributes}>\n/*<![CDATA[*/\n#{stylesheet.render_part('body')}\n/*]]>*/\n</style>}
      when 'link'
        %{<link rel="#{rel}" type="#{mime_type}" href="#{path}"#{optional_attributes} />}
      else
        stylesheet.render_part('body')
      end
    else
      raise TagError.new("stylesheet #{slug} not found")
    end
  end
  end
end