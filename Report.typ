#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm),
)

#set text(
  font: "New Computer Modern",
  size: 15pt,
  lang: "it",
)

#set par(
  justify: true,
)

// Titolo
#align(center)[
  // Titolo
  #text(size: 17pt, weight: "bold")[Report di verifica progetto Advanced Programming]

  // Spazio e tra titolo e autore
  #v(0.5cm)

  // Autore
  #text(size: 15pt)[Mario Stabile - 715424]
]

#outline() // Genera l'indice
#pagebreak() // Salta la pagina

= Introduzione
Questo report presenta la verifica e la valutazione di un progetto di web application per il rilevamento facciale, sviluppato nell'ambito dell'esame finale del corso di Advanced Programming. 

= Obiettivi del Report
Gli obiettivi di questo report sono molteplici: analizzare l'impiego dell'intelligenza artificiale nello sviluppo del codice, valutare l'efficacia del codice generato, verificare aspetti critici come la sicurezza, le prestazioni, l'accuratezza del rilevamento e la compatibilità cross-browser.
Attraverso una serie di test manuali e osservazioni, si mira a garantire che l'applicazione soddisfi i requisiti funzionali, di privacy e usabilità, fornendo un quadro completo delle sue caratteristiche e limitazioni.

= Modalità di utilizzo dell'IA
In questo progetto, l'intelligenza artificiale ha avuto il ruolo di sviluppo del codice, di selezione delle librerie da utilizzare e nell'implementazione dell'architettura complessiva della web application.

Il modello impiegato è stato l'LLM sviluppato da Google *Gemini 3 Pro*, utilizzato tramite l'ambiente di sviluppo *Antigravity*, un IDE potenziato da intelligenza artificiale rilasciato
da Google alla fine del 2025.

L'impiego dell'IA è *rimasto comunque limitato principalmente alla fase di implementazione.*
Le scelte relative al design dell'interfaccia, alla definizione delle funzionalità, agli
aspetti stilistici e alla struttura generale dell'applicazione sono state effettuate manualmente, al fine di mantenere il pieno controllo progettuale e garantire la coerenza con gli obiettivi del progetto.

= Valutazione del codice generato
Il codice generato e le funzionalità sono state valutate e verificate con modalità principalmente manuali.

== Gestione dei Permessi e Sicurezza
La verifica della sicurezza e della gestione dei permessi è stata condotta attraverso una serie di test a garantire la privacy e la robustezza del sistema.

Innanzitutto, è stato verificato il comportamento dell'applicazione al primo avvio, il browser *richiede esplicitamente il consenso per accedere alla webcam*, negando tale autorizzazione, l'applicazione ha gestito il rifiuto senza errori, disabilitando le funzionalità di rilevamento ma lasciando attiva l'interfaccia.

Per quanto riguarda la privacy dei dati, è stato eseguito un monitoraggio del traffico di rete tramite gli *strumenti di sviluppo del browser* (DevTools). Durante l'utilizzo del riconoscimento facciale, è stato verificato che non venisse effettuata alcuna richiesta verso server esterni, confermando che nessun dato video o immagine viene inviato fuori dal dispositivo.

Infine, è stata testata la *sicurezza tramite isolamento*, dopo aver caricato l'applicazione, è stata disattivata la connessione a internet. Così è stato possibile verificare che il rilevamento dei volti continuasse a funzionare perfettamente, dimostrando che *il modello risiede interamente in locale e non dipende da servizi esterni.*

== Performance
La verifica delle prestazioni si è concentrata sulla fluidità percepita durante l'utilizzo e sull'efficienza complessiva.

Per valutare la fluidità, è stata osservata la costanza degli *FPS*, verificati dal contatore integrato nell'interfaccia. 
Durante i test, l'immagine risultata abbastanza scorrevole, mantenendosi stabile sopra i 30 FPS, senza importante lag tra il movimento reale e il tracciamento del volto.

Valutando l'utilizzo delle risorse dal *System Monitor* è verificabile che l'applicazione non stressa eccessivamente CPU ne GPU, l'uso della RAM, valutata tramite il *Developer Tools* del browser, mostra che sono necessari solo pochi MB
giusto per il caricamento del modello di tracking facciale e delle risorse della pagina.


== Accuratezza del Rilevamento
Sulla base di una valutazione visiva del comportamento della rilevazione è possibile notare specifiche caratteristiche riguardo l'accuratezza del rilevamento.\

Il modello riesce in modo veloce, efficace e relativamente preciso (molto influenzato dalla distanza del soggetto) a individuare un volto umano, riuscendo a gestire allo stesso modo anche multipli individui a distanza ravvicina, disegnando più bounding-box che inquadrano i soggetti in modo abbastanza preciso ma non perfetto.\

Va fatto notare, infatti, che il modello in più occasioni risulta confuso, individuando volti dove non ci sono (durante una sessione di test, una scatola di cartone posizionata in alto nella stanza è stata considerata, pur con bassa percentuale di confidenza, un volto umano) e nella maggioranza dei casi, un'eccessiva scarsità o abbondanza di luce mette in difficoltà la precisione delle bounding-box.\

In linea generale l'accuratezza del rilevamento è buona in condizioni ottimali, mentre al deterioramento delle condizioni ambientali la precisione può calare in modo sostanziale.

== Compatibilità Cross-Browser
Il progetto è stato testato sui seguenti browser:
- *Brave Browser* (basato su Chromium)
- *Google Chrome* (basato su Chromium)
- *Opera* (basato su Chromium)
- *Microsoft Edge* (basato su Chromium)
- *Firefox*
In ognuno di questi, il software ha funzionato sotto tutti gli aspetti valutati:
- Avvio veloce dell'applicazione
- Caricamento a buon fine del modello di riconoscimento facciale
- Verifica del toggle on-off del rilevamento facciale
- funzionamento del bottone per lo screenshot con relativo download dell'immagine
- Visualizzazione delle statistiche in tempo reale
Esternamente a questi aspetti sono state notate leggere discrepanze nelle proporzioni della sezione dove viene visualizzato l'output della webcam su alcuni browser (Opera, Firefox).
Detto questo è possibile affermare che *il progetto funziona in modo ottimale in un contesto cross-browser.*

