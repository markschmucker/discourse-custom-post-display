// assets/javascripts/discourse/initializers/discourse-custom-post-display.gjs
import Component from "@glimmer/component";
import { withPluginApi } from "discourse/lib/plugin-api";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";

class CustomPostDisplay extends Component {
  @service siteSettings;

  static shouldRender(args) {
    const post = args.post;
    return !!(post && post.user);
  }

  get post() {
    return this.args.post;
  }

  get userBadges() {
    return this.post?.user_badges || [];
  }

  get joinDate() {
    return this.post?.user_join_date;
  }

  get postCount() {
    return this.post?.user_post_count;
  }

  get likesReceived() {
    return this.post?.user_likes_received;
  }

  get helpUrl() {
    return this.siteSettings?.custom_post_display_help_url;
  }

  <template>
    <div class="cpd-container">
      {{#if this.helpUrl}}
        <a
          href={{this.helpUrl}}
          title="Join Date, Posts Written, Likes Received"
        >
          <span class="cpd-span">
            {{#each this.userBadges as |badge|}}
              <span
                class="cpd-badge cpd-badge-{{badge.id}} cpd-badge-{{badge.slug}}"
              >
                <a
                  href="/badges/{{badge.id}}/{{badge.slug}}"
                  title={{badge.name}}
                >
                  {{icon badge.icon}}
                </a>
              </span>
            {{/each}}

            {{icon "calendar-days" class="cpd-join-date-icon" title="Join Date"}}
            <span
              class="cpd-text cpd-join-label"
              title="Join Date"
            >
              Joined
            </span>
            <span
              class="cpd-text cpd-join-date"
              title="Join Date"
            >
              {{this.joinDate}}
            </span>

            {{icon "pen-to-square" class="cpd-post-count-icon" title="Posts Written"}}
            <span
              class="cpd-text cpd-post-count"
              title="Posts Written"
            >
              {{this.postCount}}
            </span>

            {{icon "thumbs-up" class="cpd-likes-received-icon" title="Likes Received"}}
            <span
              class="cpd-text cpd-likes-received"
              title="Likes Received"
            >
              {{this.likesReceived}}
            </span>
          </span>
        </a>
      {{else}}
        <span class="cpd-span">
          {{#each this.userBadges as |badge|}}
            <span
              class="cpd-badge cpd-badge-{{badge.id}} cpd-badge-{{badge.slug}}"
            >
              <a
                href="/badges/{{badge.id}}/{{badge.slug}}"
                title={{badge.name}}
              >
                {{icon badge.icon}}
              </a>
            </span>
          {{/each}}

          {{icon "calendar-days" class="cpd-join-date-icon" title="Join Date"}}
          <span
            class="cpd-text cpd-join-label"
            title="Join Date"
          >
            Joined
          </span>
          <span
            class="cpd-text cpd-join-date"
            title="Join Date"
          >
            {{this.joinDate}}
          </span>

          {{icon "pen-to-square" class="cpd-post-count-icon" title="Posts Written"}}
          <span
            class="cpd-text cpd-post-count"
            title="Posts Written"
          >
            {{this.postCount}}
          </span>

          {{icon "thumbs-up" class="cpd-likes-received-icon" title="Likes Received"}}
          <span
            class="cpd-text cpd-likes-received"
            title="Likes Received"
          >
            {{this.likesReceived}}
          </span>
        </span>
      {{/if}}
    </div>
  </template>
}

export default {
  name: "discourse-custom-post-display-plugin",

  initialize() {
    withPluginApi("1.26.0", (api) => {
      api.addTrackedPostProperties(
        "user_post_count",
        "user_likes_received",
        "user_join_date",
        "user_badges"
      );

      api.renderAfterWrapperOutlet(
        "post-meta-data-poster-name",
        CustomPostDisplay
      );
    });
  },
};
