# Diskspace sublet file
# Created with sur-0.2

require "csv"
require "tempfile"

SLEEP_TIME = 0.05
HUMAN_SIZES = %w[KB MB GB TB]

configure :diskspace do |s|
  s.interval = 60*30 # every 30 minutes
  s.icon     = Subtlext::Icon.new("disk.xbm")
  s.normal_color = Subtlext::Subtle.colors[:sublets_fg]

  s.colors = s.config[:colors] || {98 => "#FF2525", 95 => "#C53535", 80 => "#A54545", 70 => "#955555", 60 => "#856565"}
  s.format_string = s.config[:format_string] || "%.01f"
  s.human_size = (s.config[:human_size] || :gb).to_s.upcase
end

helper do |s|
  def update
    # Example output of `df`:
    # Filesystem     Type  Size  Used Avail Use% Mounted on
    # /dev/sda2      ext4   15G   13G  1,5G  90% /
    # /dev/sda1      ext2   97M   55M   37M  60% /boot
    # /dev/sda3      ext4  103G   65G   33G  67% /home
    content, stderr = command(["df", "-l", "-x tmpfs", "-x devtmpfs"].join(" "))

    csv = CSV.parse(content, col_sep: " ", headers: true)
    line = csv[0]
    if line["Mounted"] == "/"
      used_perc = (line["Use%"].to_i rescue 0).round
      available = (line["Available"].to_i rescue 0)
      available = number_to_human_size(available, human_size)
      data = ["#{used_perc}%", "<#{format_string % [available]}#{human_size}"]
      color = color_of_count(used_perc)
      self.data = colorize("#{icon}#{data.join(' ')}", color)
    else
      self.data = "NOROOT"
    end
  end

  def number_to_human_size(number, size)
    index = HUMAN_SIZES.index(size) || 0
    factor = 1024**index
    number/factor.to_f
  end

  def command(command)
    prefix = 'sublet_diskspace'
    tempout, temperr = Tempfile.new([prefix, "stdout"]), Tempfile.new([prefix, "stderr"])
    pid = Process.spawn(command, out: [tempout.path, "w"], err: [temperr.path, "w"])
    sleep SLEEP_TIME
    # Process.kill("SIGKILL", pid)
    stdout = File.read(tempout); tempout.close!
    stderr = File.read(temperr); temperr.close!
    [stdout, stderr]
  end

  def colorize(string, color)
    [to_color(color), string, to_color(normal_color)].join
  end

  def color_of_count(percent)
    to_color(colors[colors.keys.select { |perc| perc <= percent }.max])
  end

  def to_color(string_or_symbol)
    case string_or_symbol
    when String, Symbol then Subtlext::Color.new(string_or_symbol)
    else string_or_symbol
    end
  end
end

on :run do |s|
  begin
    update
  rescue => err # Sanitize to prevent unloading
    s.data = "FREESPACE"
  end
end
