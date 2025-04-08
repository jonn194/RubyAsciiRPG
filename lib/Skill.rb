class Skill
  attr_reader :skill_name
  attr_reader :power
  attr_reader :cost

  def initialize()
    setup()
  end

  def setup()
    @skill_name = "-"
    @power = 0
    @cost = 0
  end

  def cast(target)
  end
end

class FireBolt < Skill
  def setup()
    @skill_name = "Firebolt"
    @power = 50
    @cost = 30
  end

  def cast(caster, target)
    puts ""
    puts "--CASTED FIREBOLT"
    caster.mana -= @cost
    target.take_damage(@power)
  end
end

class ShadowSlash < Skill
  def setup()
    @skill_name = "Shadow Slash"
    @power = 35
    @cost = 20
  end

  def cast(caster, target)
    puts ""
    puts "--CASTED SHADOW SLASH"
    caster.mana -= @cost
    target.take_damage(@power)
  end
end

class MinorHeal < Skill
  def setup()
    @skill_name = "Minor Heal"
    @power = 15
    @cost = 20
  end

  def cast(caster, target)
    puts ""
    puts "--HEALED #{@power} HP"
    caster.mana -= @cost
    caster.hp += @power
  end
end

class MagicShield < Skill
  def setup()
    @skill_name = "Magic Shield"
    @power = 30
    @cost = 40
  end

  def cast(caster, target)
    puts ""
    puts "--CASTED SHIELD OF #{@power} POWER"
    caster.mana -= @cost
    caster.shield = @power
  end
end

class MinorShield < Skill
  def setup()
    @skill_name = "Minor Shield"
    @power = 15
    @cost = 20
  end

  def cast(caster, target)
    puts ""
    puts "--CASTED SHIELD OF #{@power} POWER"
    caster.mana -= @cost
    caster.shield = @power
  end
end

class DamageUp < Skill
  def setup()
    @skill_name = "Damage Increase"
    @power = 10
    @cost = 30
  end

  def cast(caster, target)
    puts ""
    puts "--DAMAGE UP"
    caster.mana -= @cost
    caster.dmg_buff = @power
  end
end