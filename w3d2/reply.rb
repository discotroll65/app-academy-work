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

    results.map{|reply_row| Reply.new(reply_row)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL
    Reply.new(result[0])
  end


end
