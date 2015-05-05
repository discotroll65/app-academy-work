require_relative 'questions_database.rb'

class Reply
  def initialize(attrs = {})
    @id, @question_id, @parent_id, @author_id, @body =   attrs['id'],
      attrs['question_id'], attrs['parent_id'], attrs['author_id'],
      attrs['body']
  end

  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL

    result.map{|reply_row| Reply.new(reply_row)}
  end


end
