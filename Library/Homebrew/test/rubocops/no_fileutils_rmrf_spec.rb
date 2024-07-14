# frozen_string_literal: true

require "rubocops/no_fileutils_rmrf"

RSpec.describe RuboCop::Cop::Homebrew::NoFileutilsRmrf do
  subject(:cop) { described_class.new }

  describe "rm_rf" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        rm_rf("path/to/directory")
        ^^^^^^^^^^^^^^^^^^^^^^^^^^ Homebrew/NoFileutilsRmrf: #{RuboCop::Cop::Homebrew::NoFileutilsRmrf::MSG}
      RUBY
    end

    it "autocorrects" do
      corrected = autocorrect_source(<<~RUBY)
        rm_rf("path/to/directory")
      RUBY

      expect(corrected).to eq(<<~RUBY)
        rm_r("path/to/directory")
      RUBY
    end
  end

  describe "rm_f" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        rm_f("path/to/directory")
        ^^^^^^^^^^^^^^^^^^^^^^^^^ Homebrew/NoFileutilsRmrf: #{RuboCop::Cop::Homebrew::NoFileutilsRmrf::MSG}
      RUBY
    end

    it "autocorrects" do
      corrected = autocorrect_source(<<~RUBY)
        rm_f("path/to/directory")
      RUBY

      expect(corrected).to eq(<<~RUBY)
        rm("path/to/directory")
      RUBY
    end
  end

  describe "rmtree" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        rmtree("path/to/directory")
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Homebrew/NoFileutilsRmrf: #{RuboCop::Cop::Homebrew::NoFileutilsRmrf::MSG}
      RUBY
    end

    it "autocorrects" do
      corrected = autocorrect_source(<<~RUBY)
        rmtree("path/to/directory")
      RUBY

      expect(corrected).to eq(<<~RUBY)
        rm_r("path/to/directory")
      RUBY
    end
  end
end
