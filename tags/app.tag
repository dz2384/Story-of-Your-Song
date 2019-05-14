<app>
	<!-- Login page -->
	<div class="container">
		<div show={menuState==='login'}>
			<div class="wrapper">
				<form class="form-signin">
					<h2 class="form-signin-heading">Story of Your Song</h2>
					<input type="text" class="form-control" name="username" placeholder="Email Address" required="" autofocus=""/>
					<input type="password" class="form-control" name="password" placeholder="Password" required=""/>
					<label class="checkbox">
						<input type="checkbox" value="remember-me" id="rememberMe" name="rememberMe">
						Remember me
					</label>
					<div show={menuState==='login'}>
						<button class="btn btn-lg btn-primary btn-block" type="submit" onclick={ login }>Login</button>
					</div>
				</form>
			</div>
		</div>

		<!-- dashboard page -->
		<div class="row">
			<div class="col-1">
				<div show={menuState==='dashboard'}>
					<!-- Left side profile section -->
					<div>
						<span if={ user } style="font-size:x-large" class="navbar-text mr-3">{ user.displayName }</span>
					</div>
					<br>
					<!-- left side section -->
					<div>
						<div>
							<button type="button" class="btn btn-info" value='home' onclick={ toggleHome }>Browse</button>
						</div>
						<br>
						<div>
							<!-- <button type="button" onclick={ toggleBrowse }>Browse</button> -->
						</div>
						<div>
							<button type="button" class="btn btn-info" onclick={ toggleMyStories }>Home</button>
						</div>
						<div>
							<!-- <button type="button" onclick={ toggleLikedStories }>Liked stories</button> -->
						</div>
						<createstory user={ user }></createstory>
					</div>
				</div>
			</div>
			<!-- Right side section -->
			<div class="col-11">
				<br>
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
	</div>
</div>

<script>
	// JAVASCRIPT
	var tag = this;
	console.log('app.tag');
	var userRef = database.collection('user');
	//this.menuState = 'dashboard';
	this.subMenuState = 'Home';

	firebase.auth().onAuthStateChanged(userObj => {
		if (userObj) {
			this.user = userObj;
			let userId = this.user.uid
			observer.trigger('userLogin', userId)
			this.menuState = 'dashboard';
		} else {
			this.user = null;
			this.menuState = 'login';
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
</script>

</app>
