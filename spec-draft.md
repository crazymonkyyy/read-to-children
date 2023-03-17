### Read To Children File Specification(DRAFT)

A .rtc file is a rich audio-book file. Intended to increase the quality of audiobook entertainment aimed at children and pre-teens through more adding visual and audio detail. Highlighting words as they are spoken, and/or adding images like a story book. 

#### File Hierarchy 

An rtc is a renamed tar archive, with support for local symlinks //todo figure out when tar works

Symlinks MAY be used to reuse assets, and tools MUST handle them. If a symlink named "200" points at file "100.png" it MUST be interrupted as if the data of "100.png" was copied to "200.png" //todo add details as people create edge cases

#### Text

The main text file MUST be stored as the file "main.txt".

Text SHOULD be mostly plain-text stored as utf-8 with very little features, playback clients MAY ignore the complexity of unicode with two exceptions:

Non-breaking space (NBSP) character **U+00A0** : SHOULD be used to when words may be slurred together in normal speech such as "a lot" "to be"; for the purposes of the rest of the document a U+00A0 is MUST NOT be a word separator and "to(UBSP)be" MUST be a single word.

Soft Hyphen (SHY) character **U+00AD** : SHOULD be used for when you would exaggerate the pronunciation for the target audience, such as the word "supercalifragilisticexpialidocious". "Super(SHY)c..." MUST count as several words, with U+00AD MUST be counted as a word separator for the purposes of the rest of this document.

End-lines SHOULD be used liberally to help with consistent rendering, playback clients MAY choose to not have any word wrapping.

####Timings 

In a file named ".time" there should be a collection of 32-bit ints that represent the number of frames till the start of when the word is spoken.

//todo make demo and convert it to ansi c

#### Images

images should have standard file type, but be named with an integer to be associated with a word. "100.png" would be the image meant to be displayed when the 100th word is spoken.

//todo a list of acceptable image formats

//todo a list of meta data keywords to pay attention to

#### Audio

"100.mp3" would be audio that plays on the 100th word

//idk do I need to make music and sound effects have different systems?

//todo define a list of acceptable audio formats

#### Layout

in a file names layout.css, you can use a limited subset of css. //todo, figure out what pieces of css I need

#### Suggested Work Pipeline

I suggest a four step work pipeline:

1: text-blocking; converting whatever input into a modified plain text document named "main.txt" inside a folder named after the title.

2: scrape-booking; finding images and audio, coping them into the folder, associating the assets with a specif word.

3: timing; creating a ".time" file.

4: rendering/publishing; 