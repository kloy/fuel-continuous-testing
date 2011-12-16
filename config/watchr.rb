watch('../(.*).php')  { |m| code_changed(m[0]) }

def code_changed(file)
    # run "phpunit"
    puts "Executing tests..."
    run "php oil test --group=App"
    # puts "code changed"
end

def run(cmd)
    result = `#{cmd}`
    notify result rescue nil
end

def notify(message)
    puts message
    message = message.split("\n").last(3)
    title = message.find { |e| /FAILURES/ =~ e } ? "FAILURES" : "PASS"

    if title == "FAILURES"
        image = "~/.watchr_images/failed.png"
        info = /\x1b\[37;41m\x1b\[2K(.*)/.match(message[1])[1]
        data = {
            :title => title,
            :info => info,
            :image => File.expand_path(image)
        }
        notify_send data
    else
        image = "~/.watchr_images/passed.png"
        info = /\x1b\[30;42m\x1b\[2K(.*)/.match(message[1])[1]
        data = {
            :title => title,
            :info => info,
            :image => File.expand_path(image)
        }
        notifier data
    end
end

def notifier(data)
    if is_linux?
        notify_send data
    else
        growl data
    end
end

def notify_send(data)
    notifier = `which notify-send`.chomp
    title = data[:title]
    image = data[:image]
    info = data[:info]

    options = "--hint=int:transient:1 --icon '#{image}' '#{title}' '#{info}'" 
    system %(#{notifier} --hint=int:transient:1 #{options} &)
end

def growl(data)
    growlnotify = `which growlnotify`.chomp
    image = data[:image]
    title = data[:title]
    info = data[:info]

    options = "-w -n Watchr --image '#{File.expand_path(image)}' --html '#{title}' -m '#{info}'"
    system %(#{growlnotify} #{options} &)
end

def is_linux?
    RUBY_PLATFORM.downcase.include?("linux")
end