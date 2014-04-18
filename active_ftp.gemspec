Gem::Specification.new do |s|
  s.name          = 'active_ftp'
  s.version       = '0.1.0'
  s.licenses      = ['MIT']
  s.date          = '2014-04-18'
  s.summary       = 'Gem to better work with FTP'
  s.description   = 'Wrapper around Net::FTP class to add syntactic sugar'
  s.authors       = ['Abhay Kadam']
  s.email         = 'abhaykadam88@gmail.com'
  s.files         = ['lib/active_ftp.rb']
  s.homepage      = 'https://github.com/abhaykadam/active_ftp'

  s.add_dependency 'net-ftp-list', '= 3.2.6'
end
