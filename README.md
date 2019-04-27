PString is a struct contains char represent the size and string 254 byte long.

The first byte represent the size of the pString.
the main function asks for 2 serieses of inputs for 2 pStrings:
first, the size of the pString, which will be stored as the first byte at the pString address and second, the string itself.

next, the main will ask for an operation number from the user there is five options:

opt 0: prints both PString sizes.

opt 1: asks for two chars. first char is the one to be replaced and the second is the char replacing the first.
the changing will be executed for each occurance of the first char. Then, prints the results.

opt 2: asks for two indexes,start and end index. Copy's the second PString between start to end
indexes into the first PString. Then prints the first PString after the change.

opt 3:	swaps upper case with lower case and the opposite direction as well for all letters in each PString (e.g. 'A' wiil become 'a' and 'a' will become
'A'). Then prints both after the changes.

opt 4: asks for two indexes, one for each PString, then prints the (lexigographical)
comparison of both chars represented by the indexes.

In any other case invalid message will be printed to screen.
