# frozen_string_literal: true

# 场景：支付系统中的多层异常处理
# 为什么要自定义异常：业务错误需要携带领域特定上下文，普通 StandardError 不够用

class PaymentError < StandardError
  attr_reader :code, :context

  def initialize(message = '支付错误', code: nil, context: {})
    super(message)
    @code = code
    @context = context
  end
end

class InsufficientBalanceError < PaymentError
  def initialize(balance, required)
    super(
      "余额不足：当前 #{balance}，需要 #{required}",
      code: 'E_BALANCE',
      context: { balance: balance, required: required }
    )
  end
end

class InvalidCardError < PaymentError
  def initialize(card_number)
    masked = card_number.gsub(/\d(?=\d{4})/, '*')
    super(
      "无效卡号: #{masked}",
      code: 'E_INVALID_CARD',
      context: { masked_card: masked }
    )
  end
end

class PaymentService
  def process_payment(amount, card_number:, balance:)
    raise InvalidCardError, card_number unless valid_card?(card_number)
    raise InsufficientBalanceError.new(balance, amount) if balance < amount
    { status: :success, amount: amount, remaining: balance - amount }
  end

  private

  def valid_card?(number)
    number.to_s.match?(/^\d{16}$/)
  end
end

service = PaymentService.new

puts "=== 自定义异常演示 ==="

begin
  service.process_payment(100, card_number: '1234', balance: 1000)
rescue InvalidCardError => e
  puts "✗ #{e.message}"
end

begin
  service.process_payment(5000, card_number: '1111222233334444', balance: 1000)
rescue InsufficientBalanceError => e
  puts "✗ #{e.message}"
  puts "  → 建议：充值 #{e.context[:required] - e.context[:balance]} 元"
end

begin
  result = service.process_payment(100, card_number: '1111222233334444', balance: 1000)
  puts "✓ 支付成功: #{result}"
end