require 'opencv'
include OpenCV

input_window = GUI::Window.new('Input')
output_window = GUI::Window.new('Output')

begin
  img = CvMat.load("public/images/dog2.jpg").resize(CvSize.new(200, 200))
rescue
  puts '開けませんでした'

  exit
end

# チャンネル分離
b, g, r = img.split
# [#<OpenCV::CvMat:>, #<OpenCV::CvMat:>, #<OpenCV::CvMat:>]

zero = b.set_zero # NULLのかわり

# 画像達
images = [
  img, # 元画像
  (CvMat.merge b, zero, zero, zero), # 青
  (CvMat.merge zero, g, zero, zero), # 緑
  (CvMat.merge zero, zero, r, zero), # 赤
  (CvMat.merge b, g, r), # 再合成
  (CvMat.merge b, r, b) # 適当に組み換え
].zip(%w(INPUT BLUE GREEN RED MERGED CHANGED)).each do|img, name|
  GUI::Window.new(name).show img
end

# キーを押したら終了
GUI.wait_key
GUI::Window.destroy_all
