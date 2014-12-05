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

    EMAIL = {
      id: 1,
      confirmed: false,
      email: 'foo@bar.com'
    }

    MEDIA = {
      "video_url"     => "http://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "image_full" =>   "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg",
      "image_square_100x100" => "#{ASSET_URL}/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg"
    }

    NO_AVATAR = {
      full: "http://seeclickfix.com/assets/no-avatar-100.png",
      square_100x100: "http://seeclickfix.com/assets/no-avatar-100.png"
    }

    AVATAR = {
      "full" => "#{ASSET_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg",
      "square_100x100" => "#{ASSET_URL}/files/user_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf_square.jpeg"
    }

    QUESTION = {
      asker: USER_4_PUBLIC
      created_at: "2013-05-14T19:49:13-04:00", 
      id: 1,
      locale: 'en',
      question: "Is it legal to bike on the sidewalk?",
      updated_at: "2013-05-14T19:49:13-04:00"
    }

    ANSWER = {
      accepted_at: nil,    
      answer: "Pretty sure it's ok to keep chickens",
      answerer: {
        avatar: NO_AVATAR
        civic_points: 100,
        id: 10,
        name: "Mike Helpless",
        role: "Verified Official",
        witty_title: "Street Smart",
      }
      created_at: "2013-05-14T19:49:13-04:00",
      id: 4,
      locale: nil,
      question_id: 2,
      total_votes: 15,
      updated_at: "2013-05-14T19:49:13-04:00",
    }

    USER = {
      "avatar" => AVATAR,
      "civic_points" => 10,
      "closed_issue_count" => 27,
      "comments_count" => 62,
      "created_at": => "2011-03-22T17:04:31-04:00",
      "following_issue_count" => 10,
      "id"           => 1,
      "name": => "captainkickstand",
      "permissions" => {
        "can_acknowledge" => false
      },
      "reported_issue_count" => 25,
      "updated_at": => "2014-03-10T07:28:35-04:00", 
      "voted_issue_count" => 31,
      "witty_title" => "Street Smart"
    }

    USER_4_PUBLIC = {
      "avatar" => AVATAR,
      "civic_points" => 10,
      "id"           => 1,
      "name"         => "Jeffb",
      "role"         => "Verified Official",
      "witty_title"  => "Street Smart",
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
      "media" => MEDIA,
      "created_at" => "2011-04-14T16:00:49Z"
    }

    PAGINATION_METADATA = { 
      next_page:          2, 
      next_page_url:      "https://seeclickfix.com/api/v2/users?&address=New+Haven%2C+CT&page=2", 
      page:               1, 
      pages:              40457, 
      per_page:           20, 
      previous_page:     'null', 
      previous_page_url: 'null'
    }

    MOBILE_CUSTOMIZATION = {}

    GEOCODE = {}

    VOTE = {
      created_at: "2011-04-24T13:33:48Z",
      voter: USER
    }

    QUESTION0 = {
      question: "How deep is the pothole?",
      answer: "Shallow"
    }

    QUESTION1 = {
      question: "Is it hazardous?",
      answer: "No"
    }

    PLACE = {
      county: 'null', 
      created_at: '2009-09-20T20:11:30-04:00', 
      data_classification: 'City', 
      id: '1', 
      name: 'Sand Rock', 
      state: 'AL', 
      updated_at: '2012-11-11T16:57:55-05:00', 
      url_name: 'sand-rock'
    }

    NEW_ISSUE = {
      request_types: [{
        organization: "City of SeeClickFix",
        title: "Abandoned Auto",
        url: "#{ROOT_URL}/v2/request_types/121"
      },
      {
        organization: "City of SeeClickFix",
        title: "Graffiti",
        url: "#{ROOT_URL}/v2/request_types/657"
      },
      {
        organization: "City of New Haven",
        title: "Pothole",
        url: "#{ROOT_URL}/v2/request_types/122"
      },
      {
        organization: nil,
        title: 'Other',
        url: "#{ROOT_URL}/v2/request_types/other"
      }]
    }

    REQUEST_TYPE_121 = {
      id: 121,
      organization: "City of SeeClickFix",
      title: "Abandoned Auto",
      questions: [
        {
          primary_key: "142",
          question: "Type of vehicle?",
          question_type: "select",
          response_required: true,
          select_values: [
            {
              key: "CAR",
              name: "Car"
            },
            {
              key: "TRUCK",
              name: "Truck"
            }
          ]
        },
        {
          primary_key: "summary",
          question: "Issue Title",
          question_type: "text",
          response_required: true
        },
        {
          primary_key: "description",
          question: "Description",
          question_type: "textarea",
          response_required: false
        },
        {
          primary_key: "issue_image",
          question: "Issue Image",
          question_type: "file",
          response_required: false
        }
      ]
    }

    REQUEST_TYPE_657 = {
      id: 657,
      organization: "City of SeeClickFix",
      questions: [
        {
          primary_key: "400",
          question: "Graffiti is on a surface of:",
          question_type: "multivaluelist",
          response_required: true,
          select_values: [
            { key: "Brick",        name: "Brick" },
            { key: "PaintedBrick", name: "Painted Brick" },
            { key: "Wood",         name: "Wood" },
            { key: "PaintedWood",  name: "Painted Wood" },
            { key: "Metal",        name: "Metal" },
            { key: "Sandstone",    name: "Sandstone or rock" },
            { key: "Pavers",       name: "Pavers" },
            { key: "Concrete",     name: "Concrete" },
            { key: "Tarmac",       name: "Tarmac" },
            { key: "Tile",         name: "Tiles" },
            { key: "Plastic",      name: "Plastic perspex" },
            { key: "Glass",        name: "Glass" },
            { key: "Other",        name: "Other" }
          ]
        },
        {
          primary_key: "401",
          question: "Material Used to apply graffiti",
          question_type: "multivaluelist",
          response_required: true,
          select_values: [
            { key: "Paint",    name: "Paint" },
            { key: "Pen",      name: "Pen" },
            { key: "Texta",    name: "Texta" },
            { key: "Whiteout", name: "White out" },
            { key: "Crayon",   name: "Crayon" },
            { key: "Other",    name: "Other" }
          ]
        },
        {
          primary_key: "offensive",
          question: "Is the graffiti offensive?",
          question_type: "boolean",
          response_required: true
        },
        {
          primary_key: "summary",
          question: "Issue Title",
          question_type: "text",
          response_required: true
        },
        {
          primary_key: "description",
          question: "Description",
          question_type: "textarea",
          response_required: false
        },
        {
          primary_key: "issue_image",
          question: "Issue Image",
          question_type: "file",
          response_required: false
        }
      ],
      title: "Graffiti",
    }

    REQUEST_TYPE_122 = {
      id: 122,
      organization: "City of New Haven",
      questions: [
        {
          primary_key: "142",
          question: "Depth of pothole?",
          question_type: "select",
          response_required: true,
          select_values: [
            {
              key: "BUMPY",
              name: "Bumpy Surface"
            },
            {
              key: "SHALLOW",
              name: "Shallow Hole"
            },
            {
              key: "DEEP",
              name: "Deep Hole"
            }
          ]
        },
        {
          primary_key: "summary",
          question: "Issue Title",
          question_type: "text",
          response_required: true
        },
        {
          primary_key: "description",
          question: "Description",
          question_type: "textarea",
          response_required: false
        },
        {
          primary_key: "issue_image",
          question: "Issue Image",
          question_type: "file",
          response_required: false
        }
      ], 
      title: "Pothole"
    }

    REQUEST_TYPE_OTHER = {
      id: nil,
      organization: 'Community',
      questions: [
        {
          primary_key: "summary",
          question: "Issue Title",
          question_type: "text",
          response_required: true
        },
        {
          primary_key: "description",
          question: "Description",
          question_type: "textarea",
          response_required: false
        },
        {
          primary_key: "issue_image",
          question: "Issue Image",
          question_type: "file",
          response_required: false
        }
      ], 
      title: 'Post to Neighbors'
    }

    ISSUE = {
      "id"         => 1,
      "status"      => "Open",
      "summary"      => "Pothole",
      "description"       => "Please fix my neighborhood.",
      "rating"       => "5",
      "lat" => 42.30293,
      "lng" => -72.234234234,
      "point" => {
        "type" => "Point",
        "coordinates" => [
          -72.234234234,
          42.30293
        ]
      },
      "address" => "123 State St. New Haven, CT",
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z",
      "acknowledged_at"  => nil,
      "closed_at"  => nil,
      "reporter"       => USER_4_PUBLIC,
      "shortened_url"   => "http://scf.cm/i/1",
      "url"        => "#{ROOT_URL}/v2/issues/1",
      "comments_url"   => "#{ROOT_URL}/v2/issues/1/comments",
      "html_url"   => "http://seeclickfix.com/issues/1-pothole",
      "media" => MEDIA
    }

    ISSUE_DETAILS = {
      "id"         => 1,
      "remote_integration" => INTEGRATION_ISSUE,
      "rating"       => "5",
      "api_url"        => "#{ROOT_URL}/v2/issues/1",
      "html_url"   => "http://seeclickfix.com/issues/1-pothole",
      "shortened_url"   => "http://scf.cm/i/1",
      "status"      => "Open",
      "summary"      => "Pothole",
      "description"       => "Please fix my neighborhood.",
      "questions" => [QUESTION0, QUESTION1],
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
      "point" => {
        "type" => "Point",
        "coordinates" => [
          -72.234234234,
          42.30293
        ]
      },
      "current_user_relationship" => {
        :following => false,
        :voted => true,
        :reporter => false,
        :assignee => false
      },
      "address" => "123 State St. New Haven, CT",
      "media" => MEDIA,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

  end
end

include SeeClickFix::Resources::Helpers
