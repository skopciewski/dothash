# frozen_string_literal: true

# Copyright (C) 2016, 2017 Szymon Kopciewski
#
# This file is part of Dothash.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

module Dothash
  class Hash
    def self.with_dots(hash, prefix = nil)
      raise ArgumentError, "You should pass only Hash here" unless hash.is_a? ::Hash
      hash.each_with_object({}) do |(key, value), memo|
        new_key = [prefix, key].compact.join(".")
        memo.merge! with_dots_deeper(value, new_key)
      end
    end

    private_class_method def self.with_dots_deeper(value, new_key)
      if value.is_a?(::Hash)
        with_dots(value, new_key)
      elsif value.is_a? ::Array
        value.each_with_object({}).with_index do |(avalue, memo), index|
          memo.merge! with_dots({ index => avalue }, new_key)
        end
      else
        { new_key => value }
      end
    end

    def self.without_dots(hash)
      hash.each_with_object({}) do |(key, value), memo|
        key_parts = key.to_s.split(".")
        new_key = key_parts.shift.to_sym
        if key_parts.empty?
          memo[new_key] = value
        else
          deep_merge!(memo, new_key => without_dots(key_parts.join(".") => value))
        end
      end
    end

    private_class_method def self.deep_merge!(first, second)
      merger = proc do |_key, v1, v2|
        if v1.is_a?(::Hash) && v2.is_a?(::Hash)
          v1.merge(v2, &merger)
        else
          v2
        end
      end
      first.merge!(second.to_h, &merger)
    end
  end
end
