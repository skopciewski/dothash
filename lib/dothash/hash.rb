# encoding: utf-8

# Copyright (C) 2016 Szymon Kopciewski
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
    def self.convert(hash, prefix = nil)
      raise ArgumentError, "You should pass only Hash here" unless hash.is_a? ::Hash
      hash.each_with_object({}) do |(key, value), memo|
        new_key = [prefix, key].compact.join(".")
        memo.merge! go_deep(value, new_key)
      end
    end

    private_class_method def self.go_deep(value, new_key)
      if value.is_a?(::Hash)
        convert(value, new_key)
      elsif value.is_a? ::Array
        value.each_with_object({}).with_index do |(avalue, memo), index|
          memo.merge! convert({ index => avalue }, new_key)
        end
      else
        { new_key => value }
      end
    end
  end
end
