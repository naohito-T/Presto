# @NOTE Rubyで独自例外を定義する時はExceptionではなくStandardErrorがしきたり
# @see https://blog.toshimaru.net/ruby-standard-error/
# @see https://qiita.com/k-penguin-sato/items/3d8ce4e71520da2d68c4
class PrestoError < StandardError
  # 読み取り専用のメソッドが自動で定義される。
  attr_reader :attr

  def initialize(msg = 'Exception Error', attr = 'My value')
    super(msg)
    @attr = attr
  end
end

# network error
class NetworkError < PrestoError; end
