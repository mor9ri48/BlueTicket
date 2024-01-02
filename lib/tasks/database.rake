# シードデータの再投入まで行うdb:renuildタスクの作成
namespace :db do
  desc "Rebuild the development database from scratch"
  task :rebuild => :environment do
      sh "rm -f db/development.sqlite3" # SQLite3データベースの削除
      Rake::Task["db:migrate"].invoke   # マイグレーションの実行
      Rake::Task["db:seed"].invoke      # シードデータの投入
  end
end