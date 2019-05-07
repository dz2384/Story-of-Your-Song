<app>
	<!-- Login page -->
	<div show={menuState==='login'}>
		<button type="button" onclick={ login }>login</button>
	</div>

	<!-- dashboard page -->
	<div show={menuState==='dashboard'}>
		<!-- Left side profile section -->
		<div>
			<span if={ user } class="navbar-text mr-3">{ user.displayName }</span>
		</div>
		<!-- left side section -->
		<div>
			<button type="button" value='home' onclick={ toggleHome }>Home</button>
			<button type="button" onclick={ toggleBrowse }>Browse</button>
			<button type="button" onclick={ toggleMyStories }>My stories</button>
			<button type="button" onclick={ toggleLikedStories }>Liked stories</button>
			<createStory user={ user }></createStory>
		</div>
		<!-- Right side section -->
		<div>
			<div show={subMenuState==='Home'}>
				<home></home>
			</div>
			<div show={subMenuState==='Browse'}>
				<browse></browse>
			</div>
			<div show={subMenuState==='myStories'}>
				<mystories user={user}></mystories>
			</div>
			<div show={subMenuState==='likedStories'}>
				<likedstories></likedstories>
			</div>
		</div>
	</div>

	<script>
		// JAVASCRIPT
		var tag = this;
		console.log('app.tag');
		var userRef = database.collection('user');
		this.menuState = 'dashboard';
		this.subMenuState = 'Home';


		firebase.auth().onAuthStateChanged(userObj => {
			if (userObj) {
				this.user = userObj;
				let userId = this.user.uid
				observer.trigger('userLogin',userId)
			} else {
				this.user = null;
			}
			this.update();
		});

		login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		toggleHome() {
			this.subMenuState = 'Home';
		}
		toggleBrowse() {
			this.subMenuState = 'Browse';
		}
		toggleMyStories() {
			this.subMenuState = 'myStories';
		}
		toggleLikedStories() {
			this.subMenuState = 'likedStories';
		}

// 		//observer if user logged in
// 		observer.on('userLogin', userId => {
// 			userRef.doc(userId).get().then(doc=>{
// 				if (!doc.exists){
// 					var newUserRef = userRef.doc(userId);
// 					newUserRef.collection('myStory').add({
// 						message:''
// 					})
// 					newUserRef.set({
// 						id:userId,
// 						name: tag.user.displayName
// 					});
// 				}
// 			});
// });
	</script>

</app>
