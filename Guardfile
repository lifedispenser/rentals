# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  watch('Gemfile')
  watch(%r|^test/(.*)\/?(.*)\.rb|)
  watch(%r|^test/test_helper\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)

  watch(%r|^app/integration/(.*)\.rb|) { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r|^app/models/(.*)\.rb|)      { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r|^app/datatables/(.*)\.rb|)  { |m| "test/datatables/#{m[1]}_test.rb" }
  watch(%r|^app/mailers/(.*)\.rb|)     { |m| "test/mailers/#{m[1]}_test.rb" } 
end

