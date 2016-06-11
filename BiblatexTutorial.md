#Biblatex tutorial

###Step 1
Create a file with the .bib extension (mine is called "mylib.bib") in the same folder as your LaTeX document with citations in the following form:
``` 
@article{citationlabel,
   title={ },
   author={Last Name 1, First Name 1 and Last Name 2, First Name 2 and... },
   journal={ },
   volume={ },
   number={ },
   pages={ },
   year={ },
   publisher={ }
 }
```
You can either fill in the template above, or if you search the journal title in [Google scholar](scholar.google.com), click "Cite" under the article description and then click the "BibTex" link on the bottom left.

###Step 2
- Add ```\usepackage[backend=biber,maxnames=10,citestyle=science]{biblatex}``` to the top of your LaTeX document. There are many different potential [citation styles](https://www.sharelatex.com/learn/Biblatex_citation_styles) to choose from (here I chose the science style). You can also change the number of names shown before "et al", using the ```maxnames=``` option, here I have chosen 10. If you choose a citation style that uses author names for in-text citations, this will update the number of names shown for that as well. To seperately chose the number of names shown, use ```maxcitenames=``` and ```maxbibnames=``` 
- Before ```\begin{document}```, add ```\addbibresource{mylib.bib}``` 

###Step 3
Add ```\cite{citationlabel}``` for in-text citations, updating the citation label based on the article you are attempting to cite.

###Step 4
Print the bibliography at the end by adding ```\printbibliography``` to the end of the document before ```\end{document}```.

###Step 5
Compile your document. The first time you run it with new citations, you will need to rerun your document to create the bibliography, so you will compile it twice. If you are working with a ```knitr``` document, you will need to compile the .Rnw file, then open the .Tex file that is created and run that to create the bibliography, and then run the .Rnw document again to finalize the changes.