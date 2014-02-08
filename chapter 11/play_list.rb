MP3_DIRECTORY = "D:/mp3"

mp3_list = Dir[MP3_DIRECTORY + "/**/*.mp3"]
File.open "play_list.m3u", 'w' do |f|
  mp3_list.shuffle!
  mp3_list.each do |mp3_file|
    f.write mp3_file + "\n"
  end
end