# NTSpeechGrammars 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Carthage/Carthage/master/LICENSE.md)   


**NTSpeechGrammars** is a Objective-C Library for working with speech recognition grammars on iOS and OSX.

## Features
* Datastructures to dynamically work on grammars
* Parse and serialize [JSGF](http://www.w3.org/TR/jsgf/#16562) 

## How to get started
* Install
 * Manually
 * Carthage
* Import

```objc
@import NTSpeechGrammars;
// or
#import <NTSpeechGrammars/NTSpeechGrammars.h>
```

## Grammar Datastructure
![](Documentation/speech_grammar.png)

## Usage

### Creating a grammar

The grammar we want to create:
```
#JSGF V1.0;

grammar politeness;

// Body
public <startPolite> = (please | kindly | could you | oh  mighty  computer) *;
<endPolite> = [ please | thanks | thank you ];
```

```objc
// CREATE ALTERNATE LIST
NTSpeechGrammarAlternative* startPoliteAlternative = [NTSpeechGrammarAlternative alternativeWithElements:@[
  @"please",
  @"kindly",
  [NTSpeechGrammarSequence sequenceWithTokens:@[ @"could", @"you" ]],
  [NTSpeechGrammarSequence sequenceWithTokens:@[ @"oh", @"mighty", @"computer" ]]
]];

// CREATE GROUP AND SET REPETITION
NTSpeechGrammarGroup* startPoliteGroup = [NTSpeechGrammarGroup groupWithRoot:startPoliteAlternative];
startPoliteGroup.repeatMode = REPEAT_ZERO_OR_MORE;

// CREATE RULE
NTSpeechGrammarRule* startPoliteRule = [NTSpeechGrammarRule publicRuleWithName:@"startPolite" root:startPoliteGroup];

// CREATE ALTERNATE LIST
NTSpeechGrammarAlternative* endPoliteAlternative = [NTSpeechGrammarAlternative alternativeWithElements:@[
  @"please",
  @"thanks",
  [NTSpeechGrammarSequence sequenceWithTokens:@[ @"thank", @"you" ]]
]];

// CREATE RULE WITH OPTIONAL GROUP
NTSpeechGrammarRule* endPoliteRule = [NTSpeechGrammarRule ruleWithName:@"endPolite" root:[NTSpeechGrammarGroup optionalGroupWithRoot:endPoliteAlternative]];

// CREATE GRAMMAR
NTSpeechGrammar* grammar = [NTSpeechGrammar grammarWithName:@"politeness"];
grammar.version = @"V1.0";

// ADD RULES
[grammar addRule:startPoliteRule];
[grammar addRule:endPoliteRule];
```


### JSGF

```objc
// Parse from jsgf file
NTSpeechGrammar* grammar = [NTJsgfGrammar grammarFromFileAtPath:@"/path/to/grammar.jsgf"];

// Parse from string
NTSpeechGrammar* grammar = [NTJsgfGrammar grammarFromString:@"#JSGF V1.0; ........"];

// Serialize to a jsgf file
BOOL success = [NTJsgfGrammar writeGrammar:grammar toFileAtPath:@"/path/to/grammar.jsgf"];

// Serialize to string
NSString *serialized = [NTJsgfGrammar serializeGrammar:grammar];
```
