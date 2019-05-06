<createStory>

  <!-- Button trigger modal -->
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
    Create
  </button>

  <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Write something...</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="message-text" class="col-form-label">Song of your story</label>
              <textarea type="text" class="form-control" id="song-name"></textarea>
            </div>
            <div class="form-group">
              <label for="message-text" class="col-form-label">Story of your song</label>
              <textarea class="form-control" id="story-text"></textarea>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Select a Catogory
              </button>
              <div class="dropdown-menu" id = "storyType">
                <a class="dropdown-item" onclick={loveType} id = "love" value="love" href="#">Love</a>
                <a class="dropdown-item" onclick={griefType} id = "grief" href="#">Grief</a>
                <a class="dropdown-item" onclick={familyType} id = "family" href="#">Family</a>
                <a class="dropdown-item" onclick={adversityType} id = "adversity" href="#">Adversity</a>
                <a class="dropdown-item" onclick={memoryType} id = "memory" href="#">Memories</a>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick={clearInput}>Close</button>
          <button type="button" class="btn btn-primary" onclick={saveStory} data-dismiss="modal">Save changes</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    var tag = this;
    var songName;
    var storyText;
    var storyType;
    saveStory() {
      songName = document.getElementById("song-name").value;
      storyText = document.getElementById("story-text").value;

      if (songName && storyText) {
        // DATABASE WRITE - Preparation
        let collectionRef = database.collection('story');
        let docRef = collectionRef.doc();
        let id = docRef.id;

        let myStoryRef = database.collection('user').doc(this.user.uid).collection('myStory');
        let myStoryDocRef = myStoryRef.doc();
        let myStoryId = myStoryDocRef.id;
        // DATABASE WRITE - write to collection stories
        collectionRef.doc(id).set({song: songName, message: storyText, id: id, timestamp: firebase.firestore.FieldValue.serverTimestamp(), type:storyType});

        // DATABASE WRITE - write to my stories
        myStoryRef.doc(myStoryId).set({song: songName, message: storyText, id: id, timestamp: firebase.firestore.FieldValue.serverTimestamp(), type:storyType});

      }
      event.preventDefault();
      document.getElementById('story-text').value = '';
      document.getElementById('song-name').value = '';
    }

    this.on('update', () => {
      this.user = opts.user;
    });

    clearInput() {
      document.getElementById('story-text').value = '';
      document.getElementById('song-name').value = '';
    }

    loveType() {
      storyType = document.getElementById("love").text;
      console.log(storyType);
    }

    familyType() {
      storyType = document.getElementById("family").text;
      console.log(storyType);
    }

    griefType() {
      storyType = document.getElementById("grief").text;
      console.log(storyType);
    }

    adversityType() {
      storyType = document.getElementById("adversity").text;
      console.log(storyType);
    }

    memoryType() {
      storyType = document.getElementById("memory").text;
      console.log(storyType);
    }


  </script>
</createStory>
