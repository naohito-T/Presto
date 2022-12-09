# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply', "--file #{schema_file}")
  end

  desc 'DB初期化、再構成（ローカル環境で使用）'
  task initialize_db: :environment do
    if Rails.env.development? || Rails.env.test?
      system 'rake db:drop db:create'

      # development環境
      ridgepole('--apply', "--file #{schema_file}", '--env development')
      system 'rake db:schema:dump RAILS_ENV=development'

      # test環境
      ridgepole('--apply', "--file #{schema_file}", '--env test')
      system 'rake db:schema:dump RAILS_ENV=test'
    end
  end

  task dry: :environment do
    ridgepole('--apply', '--dry-run', "--file #{schema_file}")
  end

  task dry_verbose: :environment do
    ridgepole('--apply', '--dry-run --verbose', "--file #{schema_file}")
  end

  private

  def schema_file
    Rails.root.join('db/Schemafile')
  end

  def config_file
    # for production
    if ENV['DATABASE_URL'].present?
      uri = URI.parse(ENV.fetch('DATABASE_URL', nil))

      raise "Invalid uri: #{uri}" if [uri.scheme, uri.user, uri.password, uri.host, uri.path].any?(&:nil?)

      "\'{
        adapter:  #{uri.scheme},
        username: #{uri.user},
        password: #{uri.password},
        host:     #{uri.host},
        database: #{uri.path.sub(%r{\A/}, '')},
      }\'"
    else
      Rails.root.join('config/database.yml')
    end
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole', "--config #{config_file}", "--env #{Rails.env}", '--dump-with-default-fk-name']
    system [command + options].join(' ')
  end
end
