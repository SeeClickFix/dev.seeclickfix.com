require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'

module SeeClickFix
  module Resources
    module Helpers
      DefaultTimeFormat = "%B %-d, %Y".freeze

      def root_url
        Resources.const_get('ROOT_URL')
      end

      def root_version_url
        "#{root_url}/v#{Resources.const_get('VERSION')}"
      end

      def post_date(item)
        strftime item[:created_at]
      end

      def strftime(time, format = DefaultTimeFormat)
        attribute_to_time(time).strftime(format)
      end

      def headers(status, head = {})
        css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
        lines = ["Status: #{STATUSES[status]}"]

        head.each do |key, value|
          lines << "#{key}: #{value}"
        end

        #lines << "X-RateLimit-Limit: 5000"

        %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
      end

      def json(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre class="highlight"><code>) + res + "</code></pre>"
      end

    end
    
    ROOT_URL = "https://seeclickfix.com/api"
    ASSET_URL = "http://seeclickfix.com"
    VERSION = 2
    ROOT_VERSION_URL = "#{ROOT_URL}/#{VERSION}"
    

    STATUSES = {
      200 => '200 OK',
      201 => '201 Created',
      202 => '202 Accepted',
      204 => '204 No Content',
      205 => '205 Reset Content',
      301 => '301 Moved Permanently',
      302 => '302 Found',
      307 => '307 Temporary Redirect',
      304 => '304 Not Modified',
      400 => '400 Bad Request',
      401 => '401 Unauthorized',
      403 => '403 Forbidden',
      404 => '404 Not Found',
      405 => '405 Method not allowed',
      409 => '409 Conflict',
      422 => '422 Unprocessable Entity',
      500 => '500 Server Error'
    }

    INFO = {
      version: 2.0,
      base: ''
    }

    USER = {
      "display_name"        => "Jeffb",
      "id"           => 1,
      "civic_points" => 10,
      "witty_title" => "Street Smart",
      "voted_issue_count" => 31,
      "reported_issue_count" => 25,
      "comments_count" => 62,
      "closed_issue_count" => 27,
      "following_issue_count" => 10,
      "avatar" => {
        "square_100x100" => "#{ASSET_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg",
        "full" => "#{ASSET_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg"
      }
    }

    INTEGRATION_ISSUE = {
      "remote_id" => 2,
      :title => "City of New Haven",
      :status => "Accepted"
    }

    ISSUE_COMMENT = {
      "id"         => 1,
      "comment"       => "Me too",
      "commenter"       => USER,
      "media" => {
        "video_url"     => "http://www.youtube.com/watch?v=dQw4w9WgXcQ",
        "image_full" =>   "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg",
        "image_square_100x100" => "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg"
      },
      "created_at" => "2011-04-14T16:00:49Z"
    }

    MOBILE_CUSTOMIZATION = {}

    GEOCODE = {}

    VOTE = {}

    PLACE = {
      id: '1',
      state: 'CT',
      name: 'New Haven',
      url_name: 'new-haven',
      county: 'New Haven'
    }

    REPORT_FORM = {
       categories: [{ 
         organization: 'New Haven',
         title: 'Pothole',
         questions: [{
           question: 'How deep is the hole?',
           type: 'select',
           options: [
             { shallow: 'Shallow' },
             { deep: 'Deep' }
           ]
         }]
       },{ 
         organization: 'New Haven',
         title: 'Street Light Problem',
         questions: []
       },{ 
         organization: nil,
         title: 'Other',
         questions: [{
           question: 'Please Summarize',
           type: 'text'
         }]
       }]
     }

    ISSUE = {
      "id"         => 1,
      "remote_integration" => INTEGRATION_ISSUE,
      "api_url"        => "#{ROOT_URL}/v2/issues/1",
      "html_url"   => "http://seeclickfix.com/issues/1-pothole",
      "shortened_url"   => "http://scf.cm/i/1",
      "status"      => "Open",
      "summary"      => "Pothole",
      "description"       => "Please fix my neighborhood.",
      "reporter"       => USER,
      "assignee"   => USER,
      "comment_count"   => 5,
      "comments"  => [ISSUE_COMMENT, ISSUE_COMMENT],
      "vote_count"   => 2,
      "votes"        => [VOTE, VOTE],
      "closed_at"  => nil,
      "acknowledged_at"  => nil,
      "lat" => 42.30293,
      "lng" => -72.234234234,
      "current_user_relationship" => {
        :following => false,
        :voted => true,
        :reporter => false,
        :assignee => false
      },
      "address" => "123 State St. New Haven, CT",
      "media" => {
          "video_url"     => "http://www.youtube.com/watch?v=dQw4w9WgXcQ",
          "image_full" =>   "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg",
          "image_square_100x100" => "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg"
      },
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

  end
end

include SeeClickFix::Resources::Helpers
