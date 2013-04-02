require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'

module SeeClickFix
  module Resources
    module Helpers
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

      DefaultTimeFormat = "%B %-d, %Y".freeze

      def root_url
        Resources.const_get('ROOT_URL')
      end

      def root_v2_url
        "#{root_url}/v2"
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

    USER = {
      "display_name"        => "Jeffb",
      "id"           => 1,
      "place_url"     => "https://seeclickfix.com",
      "civic_points" => 10,
      "witty_title" => "Street Smart",
      "voted_issue_count" => 31,
      "reported_issue_count" => 25,
      "comments_count" => 62,
      "closed_issue_count" => 27,
      "following_issue_count" => 10,
      "square_image" => "#{ROOT_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg",
      "public_filename" => "#{ROOT_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg"
    }

    ISSUE = {
      "id"         => 1,
      "url"        => "https://api.seeclickfix.com/api/v2/issues/1",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1347",
      "status"      => "Open",
      "summary"      => "Found a bug",
      "description"       => "I'm having a problem with this.",
      "reporter"       => USER,
      "assignee"   => USER,
      "num_comments"   => 5,
      "rating"   => 2,
      "closed_at"  => nil,
      "acknowledged_at"  => nil,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

#    [
#      {
#      "id": 1,
#      "issue_id": 1,
#      "summary": "Flooding",
#      "status": "Archived",
#      "address": "",
#      "rating": 2,
#      "vote_count": 0,
#      "description": "there is severe flooding in on State Street due to clogged storm lines.",
#      "slug": "1-flooding",
#      "lat": 41.3143535624866,
#      "lng": -72.9119467735291,
#      "bitly": "http://bit.ly/82J5zf",
#      "minutes_since_created": 2608477,
#      "updated_at": "08/03/2012 at 06:31PM",
#      "created_at": "03/25/2008 at 12:32PM",
#      "user_id": "",
#      "square_image": "http://seeclickfix.com/images/categories/flood.png",
#      "reporter_display": "Ben Berkowitz",
#      "comment_count_excluding_activity": 1,
#      "voted_before": false,
#      "following": false,
#      "integration_issues": [
#    ],
#    "created_at_epoch": 1206462761000
#    }
#    ]

    ISSUE_COMMENT = {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/comments/1",
      "body"       => "Me too",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

  end
end

include SeeClickFix::Resources::Helpers
