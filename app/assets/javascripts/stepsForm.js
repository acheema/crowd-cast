
;( function( window ) {

	'use strict';

	var transEndEventNames = {
			'WebkitTransition': 'webkitTransitionEnd',
			'MozTransition': 'transitionend',
			'OTransition': 'oTransitionEnd',
			'msTransition': 'MSTransitionEnd',
			'transition': 'transitionend'
		},
		transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ],
		support = { transitions : Modernizr.csstransitions };

	function extend( a, b ) {
		for( var key in b ) {
			if( b.hasOwnProperty( key ) ) {
				a[key] = b[key];
			}
		}
		return a;
	}

	function stepsForm( el, options ) {
		this.el = el;
		this.options = extend( {}, this.options );
			extend( this.options, options );
			this._init();
	}

	stepsForm.prototype.options = {
		onSubmit : function() { return false; }
	};

	stepsForm.prototype._init = function() {
		// current question
		this.current = 0;

		// questions
		this.questions = [].slice.call( this.el.querySelectorAll( 'ol.questions > li' ) );
		// total questions
		this.questionsCount = this.questions.length;
		// show first question
		classie.addClass( this.questions[0], 'current' );

		// next question control
		this.ctrlNext = this.el.querySelector( 'button.next' );
		console.log(this.ctrlNext, "ctrlnext");

		// progress bar
		this.progress = this.el.querySelector( 'div.progress' );

		// question number status
		this.questionStatus = this.el.querySelector( 'span.number' );
		// current question placeholder
		this.currentNum = this.questionStatus.querySelector( 'span.number-current' );
		this.currentNum.innerHTML = Number( this.current + 1 );
		// total questions placeholder
		this.totalQuestionNum = this.questionStatus.querySelector( 'span.number-total' );
		this.totalQuestionNum.innerHTML = this.questionsCount;

		// error message
		this.error = this.el.querySelector( 'span.error-message' );

		// init events
		this._initEvents();
	};

	stepsForm.prototype._initEvents = function() {
		var firstInputList = [].slice.call(this.questions[ this.current ].querySelectorAll( '.listingForm' ) );

		var self = this,
			// first question

			// focus

			onFocusStartFn = function() {
					firstInputList[0].removeEventListener( 'focus', onFocusStartFn );
					classie.addClass( self.ctrlNext, 'show' );
			};
			firstInputList[0].addEventListener( 'focus', onFocusStartFn );


		// show the next question control first time the input gets focused


		// show next question
		this.ctrlNext.addEventListener( 'click', function( ev ) {
			ev.preventDefault();
			self._nextQuestion();
		} );

		// pressing enter will jump to next question
		document.addEventListener( 'keydown', function( ev ) {
			var keyCode = ev.keyCode || ev.which;
			// enter
			if( keyCode === 13 ) {
				ev.preventDefault();
				self._nextQuestion();
			}
		} );

		// disable tab
		this.el.addEventListener( 'keydown', function( ev ) {
			var keyCode = ev.keyCode || ev.which;
			// tab
			if( keyCode === 9 ) {
				ev.preventDefault();
			}
		} );
	};

	stepsForm.prototype._nextQuestion = function() {
		if( !this._validade() ) {
			return false;
		}

		// check if form is filled
		if( this.current === this.questionsCount - 1 ) {
			this.isFilled = true;
		}

		// clear any previous error messages
		this._clearError();

		// current question
		var currentQuestion = this.questions[ this.current ];

		// increment current question iterator
		++this.current;

		// update progress bar
		this._progress();

		if( !this.isFilled ) {
			// change the current question number/status
			this._updateQuestionNumber();

			// add class "show-next" to form element (start animations)
			classie.addClass( this.el, 'show-next' );

			// remove class "current" from current question and add it to the next one
			// current question
			var nextQuestion = this.questions[ this.current ];
			classie.removeClass( currentQuestion, 'current' );
			classie.addClass( nextQuestion, 'current' );
		}

		// after animation ends, remove class "show-next" from form element and change current question placeholder
		var self = this,
			onEndTransitionFn = function( ev ) {
				if( support.transitions ) {
					this.removeEventListener( transEndEventName, onEndTransitionFn );
				}
				if( self.isFilled ) {
					self._submit();
				}
				else {
					classie.removeClass( self.el, 'show-next' );
					self.currentNum.innerHTML = self.nextQuestionNum.innerHTML;
					self.questionStatus.removeChild( self.nextQuestionNum );
					// force the focus on the next input
					nextQuestion.querySelector( 'input' ).focus();
				}
			};

		if( support.transitions ) {
			this.progress.addEventListener( transEndEventName, onEndTransitionFn );
		}
		else {
			onEndTransitionFn();
		}
	}

	// updates the progress bar by setting its width
	stepsForm.prototype._progress = function() {
		this.progress.style.width = this.current * ( 100 / this.questionsCount ) + '%';
	}

	// changes the current question number
	stepsForm.prototype._updateQuestionNumber = function() {
		// first, create next question number placeholder
		this.nextQuestionNum = document.createElement( 'span' );
		this.nextQuestionNum.className = 'number-next';
		this.nextQuestionNum.innerHTML = Number( this.current + 1 );
		// insert it in the DOM
		this.questionStatus.appendChild( this.nextQuestionNum );
	}

	// submits the form
	stepsForm.prototype._submit = function() {
		console.log(this.el, "submitted");
		this.options.onSubmit( this.el );
	}

	// TODO (next version..)
	// the validation function
	stepsForm.prototype._validade = function() {
		// current question´s input
		var inputs = [].slice.call(this.questions[ this.current ].querySelectorAll( '.listingForm' ) );
		var i =0;
		// check that either the lat/lon or the address is filled in
		var m =0;
		var n = 0;
		var latLon = [].slice.call(this.questions[this.current].querySelectorAll('.gps'));
		var address = [].slice.call(this.questions[this.current].querySelectorAll('.address'));
		for (i; i<inputs.length; i++) {
			console.log(inputs[i]);
			// check for empty strings in the div class: listingForm, special error checking for location (either the address needs to be filled, or the lat/lon)
			if ($(inputs[i]).attr('class').indexOf('gps') != -1) {
				// we are dealing with the special location case.

				// check if lat/lon filled out
				var n = 0;
				if ($(latLon[0]).val() == '' || $(latLon[1]).val() == '') {
					for (n; n<address.length; n++) {
						if ($(address[n]).val() == '') {
							this._showError( 'ADDRESS_NOT_FILLED');
							return false;
						}
					}
					}
					return true;

				}

			else if ( inputs[i].value == '') {
			this._showError( 'EMPTYSTR');
			return false;
		}
}
return true;

}

	// TODO (next version..)
	stepsForm.prototype._showError = function( err ) {
		var message = '';
		switch( err ) {
			case 'EMPTYSTR' :
				message = 'Please fill out all the fields before continuing';
				break;
			case 'INVALIDEMAIL' :
				message = 'Please fill a valid email address';
				break;
			case 'ADDRESS_NOT_FILLED':
				message = "Please fill out either an address or find your location on the map"
			// ...
		};
		this.error.innerHTML = message;
		classie.addClass( this.error, 'show' );
	}

	// clears/hides the current error message
	stepsForm.prototype._clearError = function() {
		classie.removeClass( this.error, 'show' );
	}

	// add to global namespace
	window.stepsForm = stepsForm;

})( window );
