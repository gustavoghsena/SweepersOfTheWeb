//
//  SoundManager.swift
//  WWDC24
//
//  Created by Gustavo Sena on 15/02/24.
//

import AVFoundation

class SoundManager {
    
    static var shared = SoundManager()
    
    private var soundDict: [Sound: AVAudioPlayer?] = [:]
    
    init() {
        for sound in Sound.allCases {
            soundDict[sound] = getAudioPlayer(sound: sound)
        }
    }
    
    private func getPlaybackTime(sound: Sound) -> TimeInterval {
        let playbackTime = UserDefaults.standard.double(forKey: sound.rawValue)
        return max(playbackTime, 0)
    }

    private func getAudioPlayer(sound: Sound) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            print("Fail to get url for \(sound)")
            return nil
        }

        var audioPlayer: AVAudioPlayer?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            return audioPlayer
        } catch {
            print("Fail to load \(sound)")
            return nil
        }
    }
    
    func playLoop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    func play(sound: Sound, fadeInDuration: TimeInterval = 0) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        if fadeInDuration > 0 {
            audioPlayer.volume = 0
            audioPlayer.play()
            audioPlayer.setVolume(1, fadeDuration: fadeInDuration)
        } else {
            audioPlayer.play()
        }
    }
    
    func pause(sound: Sound, fadeOutDuration: TimeInterval = 0) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        if fadeOutDuration > 0 {
            audioPlayer.setVolume(0, fadeDuration: fadeOutDuration)
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutDuration) {
                audioPlayer.pause()
                UserDefaults.standard.set(audioPlayer.currentTime, forKey: sound.rawValue)
            }
        } else {
            audioPlayer.pause()
            UserDefaults.standard.set(audioPlayer.currentTime, forKey: sound.rawValue)
        }
    }
    
    func stop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.stop()
        UserDefaults.standard.set(0, forKey: sound.rawValue)
    }
    
    func resume(sound: Sound, fadeInDuration: TimeInterval = 0) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.currentTime = getPlaybackTime(sound: sound)
        if fadeInDuration > 0 {
            audioPlayer.volume = 0
            audioPlayer.play()
            audioPlayer.setVolume(1, fadeDuration: fadeInDuration)
        } else {
            audioPlayer.play()
        }
    }
    
    enum Sound: String, CaseIterable {
        case backgroundSong
        case collisionWarning
        case deathExplosion
        case disarmedTrap
        case disarmFail
        case seaSounds
        case winBanjo
    }
}
